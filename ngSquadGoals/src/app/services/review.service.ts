import { Review } from './../models/review';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ReviewService {


  private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/users'; // change 'todos' to your API path
  private url = this.baseUrl + 'api/reviews'; // change 'todos' to your API path
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
  return this.http.get<Review[]>(this.url,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('ReviewService.index(): error retrieving Reviews: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Review>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('ReviewService.show(): error retrieving Review: ' +id + err)
    );
  })
  );

}
createReview(review: Review){
  return this.http.post<Review>(this.url,review, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('ReviewService.createPark(): error creating Review: '  + err)
      );
    })
    );

  }
  updateReview(review: Review, id:number){
    return this.http.put<Review>(this.url+'/'+id,review, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ReviewService.updatePark(): error updating Review: '  + err)
        );
      })
      );

    }
    deleteReview(id:number){
      return this.http.delete<Review>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ReviewService.deletePark(): error deleting Review: ' +id + err)
        );
      })
      );

    }
    showReview(reviewId: any){
      return this.http.get<Review>("http://localhost:8088/api/reviews/" + reviewId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ReviewService.showUser(): error retrieving Review: ' + err)
        );
      })
    );
    }
  }

