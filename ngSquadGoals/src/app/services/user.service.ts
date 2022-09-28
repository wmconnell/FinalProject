import { User } from 'src/app/models/user';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {



  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/users'; // change 'todos' to your API path
  private url = this.baseUrl + 'api/users'; // change 'todos' to your API path
  constructor(private http: HttpClient, private auth: AuthService) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

index(){
  return this.http.get<User[]>(this.url,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.index(): error retrieving users: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<User>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.show(): error retrieving user: ' +id + err)
    );
  })
  );

}
createUser(user: User){
  return this.http.post<User>(this.url,user, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.createPark(): error creating user: '  + err)
      );
    })
    );

  }
  updateUser(user: User, id:number){
    return this.http.put<User>(this.url+'/'+id,user, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('UserService.updatePark(): error updating park: '  + err)
        );
      })
      );

    }
    deleteUser(id:number){
      return this.http.delete<User>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.deletePark(): error deleting user: ' +id + err)
        );
      })
      );

    }
    showUser(userId: any){
      return this.http.get<User>("http://localhost:8088/api/users/" + userId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TodoService.showUser(): error retrieving todos: ' + err)
        );
      })
    );
    }

    getUsersBySquad(squadId: number) {
      return this.http.get<User[]>(this.url+'/squads/'+squadId, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GoalService.show(): error retrieving goal: ' +squadId + err)
        );
      })
      );
    }
  }


