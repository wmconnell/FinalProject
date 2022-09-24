import { Squad } from './../models/squad';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class SquadService {

    // private baseUrl = 'http://localhost:8082/'; // adjust port to match server
    private url = environment.baseUrl + 'api/squads'; // change 'todos' to your API path
    constructor(private http: HttpClient) { }

  index(){
    return this.http.get<Squad[]>(this.url).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ParkService.index(): error retrieving squads: ' + err)
      );
    })
  );
  }
  show(id:number){
    return this.http.get<Squad>(this.url+'/'+id).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ParkService.show(): error retrieving squad: ' +id + err)
      );
    })
    );

  }
  createUser(squad: Squad){
    return this.http.post<Squad>(this.url,squad).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ParkService.createPark(): error creating squad: '  + err)
        );
      })
      );

    }
    updateUser(squad: User, id:number){
      return this.http.put<Squad>(this.url+'/'+id,squad).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ParkService.updatePark(): error updating squad: '  + err)
          );
        })
        );

      }
      deleteUser(id:number){
        return this.http.delete<Squad>(this.url+'/'+id).pipe(catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('ParkService.deletePark(): error deleting squad: ' +id + err)
          );
        })
        );

      }

    }



