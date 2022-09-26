import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { Tag } from '../models/tag';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TagService {


  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/tags'; // change 'todos' to your API path
  private url = this.baseUrl + 'api/tags'; // change 'todos' to your API path
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
  return this.http.get<Tag[]>(this.url,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('TagService.index(): error retrieving Tags: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Tag>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('TagService.show(): error retrieving Tag: ' +id + err)
    );
  })
  );

}
createTag(tag: Tag){
  return this.http.post<Tag>(this.url,tag, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('TagService.createPark(): error creating Tag: '  + err)
      );
    })
    );

  }
  updateTag(tag: Tag, id:number){
    return this.http.put<Tag>(this.url+'/'+id,tag, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('TagService.updatePark(): error updating Tag: '  + err)
        );
      })
      );

    }
    deleteTag(id:number){
      return this.http.delete<Tag>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TagService.deletePark(): error deleting Tag: ' +id + err)
        );
      })
      );

    }
    showTag(tagId: any){
      return this.http.get<Tag>("http://localhost:8088/api/tags/" + tagId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TagService.showTag(): error retrieving Tags: ' + err)
        );
      })
    );
    }
  }

