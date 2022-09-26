import { Goal } from './../models/goal';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { HttpClient } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class GoalService {

  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/users'; // change 'todos' to your API path
  private url = this.baseUrl + 'api/goals'; // change 'todos' to your API path
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
  return this.http.get<Goal[]>(this.url).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('GoalService.index(): error retrieving goals: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Goal>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('GoalService.show(): error retrieving goal: ' +id + err)
    );
  })
  );

}
createUser(goal: Goal){
  return this.http.post<Goal>(this.url,goal, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('GoalService.createGoal(): error creating goal: '  + err)
      );
    })
    );

  }
  updateUser(goal: Goal, id:number){
    return this.http.put<Goal>(this.url+'/'+id,goal, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('UserService.updateGoal(): error updating goal: '  + err)
        );
      })
      );

    }
    deleteUser(id:number){
      return this.http.delete<Goal>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.deletePark(): error deleting user: ' +id + err)
        );
      })
      );

    }
    showUser(userId: any){
      return this.http.get<Goal>("http://localhost:8088/api/goals/" + userId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TodoService.showUser(): error retrieving todos: ' + err)
        );
      })
    );
    }
  }



