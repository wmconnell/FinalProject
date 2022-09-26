export class Review {
  id: any = null; //**VERIFY** EMBEDDED ID
  rating: number = 0;
  comment: string = '';
  reviewDate: Date | null = null; //dates not initialized
  user: any = null;
  goal: any = null;
  images: any[] = [];

  constructor(
    id: any = null, //**VERIFY** EMBEDDED ID
  rating: number = 0,
  comment: string = '',
  reviewDate: Date | null = null,
  user: any = null,
  goal: any = null,
  images: any[] = []
  ) {
  this.id = id;
  this.rating = rating;
  this.comment = comment;
  this.reviewDate = reviewDate;
  this.user = user;
  this.goal = goal;
  this.images = images;
  }
}
