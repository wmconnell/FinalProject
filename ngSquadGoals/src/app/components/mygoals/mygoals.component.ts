import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { Goal } from 'src/app/models/goal';
import { Squad } from 'src/app/models/squad';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { SquadService } from 'src/app/services/squad.service';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-mygoals',
  templateUrl: './mygoals.component.html',
  styleUrls: ['./mygoals.component.css']
})
export class MygoalsComponent implements OnInit {

  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private goalService: GoalService, private taskService: TaskService, private squadService: SquadService) { }



  loggedIn: User = new User();
  squads: Squad[] = [];
  goals: Goal[] = [];
  newGoal: Goal = new Goal();
  goalToUpdate: Goal = new Goal();
  addGoal: boolean = false;
  updateGoal: boolean = false;
  squadName: string = '';
  squadId: number = 0;
  tasks: Task[] =[];
  squadToEditId: number = 0;

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

        this.getSquads();
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
  }

  createGoal(form: NgForm, squadId:number): void {
    let goal = {} as Goal;
    goal.title = form.value.title;
    goal.description = form.value.description;
    goal.endDate = form.value.endDate;
    console.log("CREATE GOAL");
    goal.active = true;
    console.log(goal);

    this.goalService.createGoal(goal).subscribe({

      next: (result) => {
        this.newGoal = new Goal();
        this.goalService.addSquadToGoal(result.id, squadId).subscribe({
          next: () => {
            this.load();
          },
          error: (nojoy) => {
             console.error('error creating goal:');
            console.error(nojoy);
          }
        });
      },
      error: (nojoy) => {
        console.error('error creating goal:');
        console.error(nojoy);
      }
    });
  }

  doUpdateGoal(goal: Goal): void {
    this.goalService.updateGoal(goal, goal.id).subscribe({

      next: (result) => {
        this.goalToUpdate = new Goal();
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
      this.getAllGoals();
      console.log(result);
      // console.log("this.squads: " + this.squads);
    },
    error: (nojoy) => {
      console.error('error retrieving squads:');
      console.error(nojoy);
    },
  })
  }

  getAllGoals = (): void => {
    this.goals = [];
    let getDemGoals = this.getGoalBySquad;
    this.squads.forEach(function(squad) {
      console.log("Dat squad id: " + squad.id);
      getDemGoals(squad);
  })
}

  getGoalBySquad = (squad: Squad): void => {
    this.goalService.getGoalsBySquad(squad.id).subscribe({
      next: (result) => {
        squad.goals = result;
        console.log("gol num:" + this.goals.length);
      }
    })

  }

  delete = (id: number): void => {
    this.goalService.deleteGoal(id).subscribe({

      next: (result) => {
        this.load();
      },
      error: (nojoy) => {
        console.error('error creating goal:');
        console.error(nojoy);
      },
    });
  }

}

