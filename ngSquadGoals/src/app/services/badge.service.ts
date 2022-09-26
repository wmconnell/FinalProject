import { Badge } from './../models/badge';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class BadgeService {


  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/badges'; // change 'todos' to your API path
  private url = this.baseUrl + 'api/badges'; // change 'todos' to your API path
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
  return this.http.get<Badge[]>(this.url,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('BadgeService.index(): error retrieving Badges: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Badge>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('BadgeService.show(): error retrieving Badge: ' +id + err)
    );
  })
  );

}
createBadge(badge: Badge){
  return this.http.post<Badge>(this.url,badge, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('BadgeService.createPark(): error creating Badge: '  + err)
      );
    })
    );

  }
  updateBadge(badge: Badge, id:number){
    return this.http.put<Badge>(this.url+'/'+id,badge, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('BadgeService.updatePark(): error updating Badge: '  + err)
        );
      })
      );

    }
    deleteBadge(id:number){
      return this.http.delete<Badge>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('BadgeService.deletePark(): error deleting Badge: ' +id + err)
        );
      })
      );

    }
    showBadge(badgeId: any){
      return this.http.get<Badge>("http://localhost:8088/api/badges/" + badgeId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('BadgeService.showBadge(): error retrieving Badges: ' + err)
        );
      })
    );
    }
  }




