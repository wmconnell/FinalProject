import { SquadService } from 'src/app/services/squad.service';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { Goal } from 'src/app/models/goal';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';
import { Squad } from 'src/app/models/squad';

@Component({
  selector: 'app-goal',
  templateUrl: './goal.component.html',
  styleUrls: ['./goal.component.css']
})
export class GoalComponent implements OnInit {


  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private goalService: GoalService, private taskService: TaskService, private squadService: SquadService) { }

  loggedIn: User = new User();
  squads: Squad[] = [];
  goals: Goal[] = [];
  newGoal: Goal = new Goal();
  addGoal: boolean = false;

  ngOnInit(): void {
    this.load();
  }

  isLoggedIn(){
    if(this.auth.checkLogin()){
      return true
    }
    else{
      return false;
    }
  }

  load = (): void => {
    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        this.loggedIn = user;
        console.log(user.goals.length)
        this.getAllGoals();
        this.getSquads();
        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
  }

  createGoal(goal: Goal): void {
    goal.creator = this.loggedIn;
    goal.active = true;
    goal.squads.push(this.loggedIn.squads)
    this.goalService.createGoal(goal).subscribe({

      next: (result) => {
        this.newGoal = new Goal();
        // this.newGoal.creator = this.loggedIn;
        this.load();
      },
      error: (nojoy) => {
        console.error('error creating goal:');
        console.error(nojoy);
      },
    });
  }

  getSquads = (): void => {
  this.squadService.squadsByUser().subscribe({
    next: (result) => {
      this.squads = result;
      console.log(result);
      console.log(this.squads);
    },
    error: (nojoy) => {
      console.error('error retrieving squads:');
      console.error(nojoy);
    },
  })
  }

  getAllGoals = (): void => {
    let user = this.loggedIn;
    user.goals = [];
    this.goalService.index().subscribe({
      next: (result) => {
        result.forEach(function (goal: Goal) {
          console.log(goal.users.length)
          if (goal.users) {
          goal.users.forEach(function (goalUser: User) {
            if (goalUser.id === user.id) {
              user.goals.push(goal);

          }});
        }
        });
      }
    })
  }



}
