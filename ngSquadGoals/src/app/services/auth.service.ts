import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { tap, catchError, throwError, Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { Buffer } from "buffer";
@Injectable({
  providedIn: 'root',
})
export class AuthService {
  // Set port number to server's port
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/users';

  constructor(private http: HttpClient) { }

  register(user: User): Observable<User> {
    // Create POST request to register a new account
    return this.http.post<User>(this.baseUrl + 'register', user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.register(): error registering user.')
        );
      })
    );
  }

  login(username: string, password: string): Observable<User> {
    // Make credentials
    const credentials = this.generateBasicAuthCredentials(username, password);
    // Send credentials as Authorization header specifying Basic HTTP authentication
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };

    // Create GET request to authenticate credentials
    return this.http.get<User>(this.baseUrl + 'authenticate', httpOptions).pipe(
      tap((newUser) => {
        console.log(newUser);

        // While credentials are stored in browser localStorage, we consider
        // ourselves logged in.
        localStorage.setItem('credentials', credentials);
        localStorage.setItem('username', username);
        return newUser;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.login(): error logging in user.')
        );
      })
    );
  }

  logout(): void {
    localStorage.removeItem('credentials');
    localStorage.removeItem('username');
  }

  getLoggedInUser(): Observable<User> {
    if (!this.checkLogin()) {
      return throwError(() => {
        new Error('Not logged in.');
      });
    }
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      },
    };
    return this.http
    .get<User>(environment.baseUrl + 'authenticate', httpOptions)
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error( 'AuthService.getUserById(): error retrieving user: ' + err )
          );
        })
      );
  }

  getUser(username: string): Observable<User> {
    return this.http.get<User>(`${this.url}/${username}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.getUser(): error retrieving user: ' + err)
        );
      }));
  }

  checkLogin(): boolean {
    if (localStorage.getItem('credentials')) {
      return true;
    }
    return false;
  }

  checkUsernameUnique(username: string): Observable<boolean> {
    return this.http.get<boolean>(environment.baseUrl + "checkusernameunique/" + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.checkUsernameUnique() - error: ' + err)
        );
      }
    )
    );
  }

  generateBasicAuthCredentials(username: string, password: string): string {
    return Buffer.from(`${username}:${password}`).toString('base64');
  }

  getCredentials(): string | null {
    return localStorage.getItem('credentials');
  }
  getUserName()  {
    if(localStorage.getItem('username')){

      return localStorage.getItem('username');
    }
    return "";
    // return this.http.get<boolean>(this.baseUrl+'/'+username).pipe(tap((newUser)))
  }
}
