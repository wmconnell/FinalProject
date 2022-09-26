import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { Task } from '../models/task';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TaskService {


  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/tasks'; // change 'todos' to your API path
  private url1 = this.baseUrl + 'api/goals'; // change 'todos' to your API path
  private url2 = this.baseUrl + 'api/tasks'; // change 'todos' to your API path
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
  return this.http.get<Task[]>(this.url2,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('TaskService.index(): error retrieving Tasks: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Task>(this.url2+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('TaskService.show(): error retrieving Task: ' +id + err)
    );
  })
  );

}
createTask(task: Task){
  return this.http.post<Task>(this.url2,task, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('TaskService.createPark(): error creating Task: '  + err)
      );
    })
    );

  }
  updateTask(task: Task, id:number){
    return this.http.put<Task>(this.url2+'/'+id,task, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('TaskService.updatePark(): error updating Task: '  + err)
        );
      })
      );

    }
    deleteTask(id:number){
      return this.http.delete<Task>(this.url2+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TaskService.deletePark(): error deleting Task: ' +id + err)
        );
      })
      );

    }
    showTask(taskId: any){
      return this.http.get<Task>("http://localhost:8084/api/tasks/" + taskId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TodoService.showTask(): error retrieving Tasks: ' + err)
        );
      })
    );
    }
  }



