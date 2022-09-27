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
  goalToUpdate: Goal = new Goal();
  addGoal: boolean = false;
  updateGoal: boolean = false;
  squadName: string = '';
  squadId: number = 0;

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
    // let currentSquadName = this.squadName;
    // goal.squads = getSquadByName(this.squadName);
    // goal.squads.push(this.squads[0]);
    // this.squads.forEach(function (squad) {
    //   if (squad.name === currentSquadName) {
    //   goal.squads = [];
    //   goal.squads.push(squad);
    //   }
    // })
    // console.log("SquadName: " + this.squadName);
    // console.log("Num Squads: " + goal.squads.length)
    let squad: Squad = new Squad();
    squad.id = this.squadId;
    goal.squads.push(squad);
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
