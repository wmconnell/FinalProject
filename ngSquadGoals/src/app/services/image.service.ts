import { Image } from './../models/image';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ImageService {


  // private baseUrl = 'http://localhost:8088/'; // adjust port to match server
  // private url = environment.baseUrl + 'api/images'; // change 'todos' to your API path
  private url = environment.baseUrl + 'api/images'; // change 'todos' to your API path
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
  return this.http.get<Image[]>(this.url,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('ImageService.index(): error retrieving images: ' + err)
    );
  })
);
}
show(id:number){
  return this.http.get<Image>(this.url+'/'+id,this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('ImageService.show(): error retrieving image: ' +id + err)
    );
  })
  );

}

getImageBySquad(squadId: number) {
  return this.http.get<Image>(this.url + '/squad/' + squadId, this.getHttpOptions()).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ImageService.createPark(): error creating image: '  + err)
        );
      })
      );
}

createImage(image: Image){
  return this.http.post<Image>(this.url,image, this.getHttpOptions()).pipe(catchError((err: any) => {
    console.log(err);
    return throwError(
      () => new Error('ImageService.createPark(): error creating image: '  + err)
      );
    })
    );

  }
  updateImage(image: Image, id:number){
    return this.http.put<Image>(this.url+'/'+id,image, this.getHttpOptions()).pipe(catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ImageService.updatePark(): error updating image: '  + err)
        );
      })
      );

    }
    deleteImage(id:number){
      return this.http.delete<Image>(this.url+'/'+id, this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ImageService.deletePark(): error deleting image: ' +id + err)
        );
      })
      );

    }
    showBadge(imageId: any){
      return this.http.get<Image>(this.url + imageId,this.getHttpOptions()).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ImageService.showImage(): error retrieving Images: ' + err)
        );
      })
    );
    }
  }

