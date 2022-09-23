export class Image {
  id: number = 0;
  url: string = '';
  user: any = null;
  squad: any = null;
  goals: any[] = [];
  reviews: any[] = [];

  constructor(
    id: number = 0,
  url: string = '',
  user: any = null,
  squad: any = null,
  goals: any[] = [],
  reviews: any[] = []
  ) {
  this.id = id;
  this.url = url;
  this.user = user;
  this.squad = squad;
  this.goals = goals;
  this.reviews = reviews;
  }
}
