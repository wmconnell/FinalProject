import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TaskService {


  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/users'; // change 'todos' to your API path
  private url1 = this.baseUrl + 'api/goals'; // change 'todos' to your API path
  private url2 = this.baseUrl + 'api/task'; // change 'todos' to your API path
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
  return this.http.get<Task[]>(this.url1,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.index(): error retrieving Tasks: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Task>(this.url1+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.show(): error retrieving Task: ' +id + err)
    );
  })
  );

}
createTask(task: Task){
  return this.http.post<Task>(this.url1,task, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('UserService.createPark(): error creating Task: '  + err)
      );
    })
    );

  }
  updateTask(task: Task, id:number){
    return this.http.put<Task>(this.url2+'/'+id,task, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('UserService.updatePark(): error updating Task: '  + err)
        );
      })
      );

    }
    deleteTask(id:number){
      return this.http.delete<User>(this.url2+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.deletePark(): error deleting Task: ' +id + err)
        );
      })
      );

    }
    showTask(taskId: any){
      return this.http.get<User>("http://localhost:8084/api/todos/" + taskId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TodoService.showUser(): error retrieving Tasks: ' + err)
        );
      })
    );
    }
  }



