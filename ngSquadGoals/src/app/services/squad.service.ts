import { Squad } from './../models/squad';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class SquadService {

    private baseUrl = 'http://localhost:8088/'; // adjust port to match server
    private url = this.baseUrl + 'api/squads'; // change 'todos' to your API path
    constructor(private http: HttpClient,private auth: AuthService) { }

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
    return this.http.get<Squad[]>(this.url, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ParkService.index(): error retrieving squads: ' + err)
      );
    })
  );
  }
  show(id:number){
    return this.http.get<Squad>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ParkService.show(): error retrieving squad: ' +id + err)
      );
    })
    );

  }
  createSquad(squad: Squad){
    return this.http.post<Squad>(this.url,squad, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ParkService.createPark(): error creating squad: '  + err)
        );
      })
      );

    }
    updateSquad(squad: Squad, id:number){
      return this.http.put<Squad>(this.url+'/'+id,squad, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ParkService.updatePark(): error updating squad: '  + err)
          );
        })
        );

      }
      addMember(squadId: number, memberId:number){
      return this.http.get<Squad>(this.url+'/'+squadId+'/'+memberId, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ParkService.updatePark(): error updating squad: '  + err)
          );
        })
        );

      }
      deleteSquad(id:number){
        return this.http.delete<Squad>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('SquadService.deletePark(): error deleting squad: ' +id + err)
          );
        })
        );

      }

    }


