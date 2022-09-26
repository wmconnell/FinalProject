export class Task {
  id: number = 0;
  title: string = '';
  description: string = '';
  createdDate: Date | null = null;
  updatedDate: Date | null = null;
  completedDate: Date | null = null;
  startDate: Date | null = null;
  endDate: Date | null = null;
  completed: boolean = false;
  users: any[] = [];
  squads: any[] = [];
  goal: any = null;
  prerequisites: any = null;

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
  users: any[] = [],
  squads: any[] = [],
  goal: any = null,
  prerequisites: any = null
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
  this.users = users;
  this.squads = squads;
  this.goal = goal;
  this.prerequisites = prerequisites;
  }

}
