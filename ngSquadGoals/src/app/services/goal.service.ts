import { Goal } from './../models/goal';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { HttpClient } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class GoalService {

  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/goals'; // change 'todos' to your API path
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
createGoal(goal: Goal){
  return this.http.post<Goal>(this.url,goal, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('GoalService.createGoal(): error creating goal: '  + err)
      );
    })
    );

  }
  updateGoal(goal: Goal, id:number){
    return this.http.put<Goal>(this.url+'/'+id,goal, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('GoalService.updateGoal(): error updating goal: '  + err)
        );
      })
      );

    }
    deleteGoal(id:number){
      return this.http.delete<Goal>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GoalService.deletePark(): error deleting goal: ' +id + err)
        );
      })
      );

    }
    showGoal(goalId: any){
      return this.http.get<Goal>("http://localhost:8088/api/goals/" + goalId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GoalService.showGoal(): error retrieving Goals: ' + err)
        );
      })
    );
    }
  }



