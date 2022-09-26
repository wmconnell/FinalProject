export class Goal {
  id: number = 0;
  title: string = '';
  description: string = '';
  createdDate: Date | null = null;  //dates not initialized
  updatedDate: Date | null = null;
  completedDate: Date | null = null;
  startDate: Date | null = null;
  endDate: Date | null = null;
  completed: boolean = false;
  publicVisibility: boolean = false;
  publicAttendance: boolean = false;
  recurring: string = '';
  active: boolean = false;
  reviews: any[] = [];
  users: any[] = [];
  squads: any[] = [];
  images: any[] = [];
  creator: any = null;
  tasks: any[] = [];
  tags: any[] = [];

  constructor(
    id: number = 0,
  title: string = '',
  description: string = '',
  createdDate: Date | null = null,
  updatedDate: Date | null = null,
  completedDate: Date | null = null,
  startDate: Date | null = null,
  endDate: Date | null = null,
  completed: boolean = false,
  publicVisibility: boolean = false,
  publicAttendance: boolean = false,
  recurring: string = '',
  active: boolean = false,
  reviews: any[] = [],
  users: any[] = [],
  squads: any[] = [],
  images: any[] = [],
  creator: any = null,
  tasks: any[] = [],
  tags: any[] = []
  ) {
  this.id = id;
  this.title = title;
  this.description = description;
  this.createdDate = createdDate;
  this.updatedDate = updatedDate;
  this.completedDate = completedDate;
  this.startDate = startDate;
  this.endDate = endDate;
  this.completed = completed;
  this.publicVisibility = publicVisibility;
  this.publicAttendance = publicAttendance;
  this.recurring = recurring;
  this.active = active;
  this.reviews = reviews;
  this.users = users;
  this.squads = squads;
  this.images = images;
  this.creator = creator;
  this.tasks = tasks;
  this.tags = tags;


  }
}
