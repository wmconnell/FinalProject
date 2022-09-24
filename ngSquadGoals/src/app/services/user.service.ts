import { User } from 'src/app/models/user';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {



  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/users'; // change 'todos' to your API path
  private url = this.baseUrl + 'api/users'; // change 'todos' to your API path
  constructor(private http: HttpClient) { }

index(){
  return this.http.get<User[]>(this.url).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.index(): error retrieving users: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<User>(this.url+'/'+id).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.show(): error retrieving user: ' +id + err)
    );
  })
  );

}
createUser(user: User){
  return this.http.post<User>(this.url,user).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.createPark(): error creating user: '  + err)
      );
    })
    );

  }
  updateUser(user: User, id:number){
    return this.http.put<User>(this.url+'/'+id,user).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('UserService.updatePark(): error updating park: '  + err)
        );
      })
      );

    }
    deleteUser(id:number){
      return this.http.delete<User>(this.url+'/'+id).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.deletePark(): error deleting user: ' +id + err)
        );
      })
      );

    }

  }


