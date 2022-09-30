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
import { animate, state, style, transition, trigger } from '@angular/animations';
import { Image } from './../../models/image';
import { MatDialog } from '@angular/material/dialog';
import { EditGoalDialogComponent } from '../edit-goal-dialog/edit-goal-dialog.component';
import { DeleteConfirmationDialogComponent } from '../delete-confirmation-dialog/delete-confirmation-dialog.component';
import { AddGoalDialogComponent } from '../add-goal-dialog/add-goal-dialog.component';


@Component({
  selector: 'app-mygoals',
  templateUrl: './mygoals.component.html',
  styleUrls: ['./mygoals.component.css'],
  animations: [
    trigger('detailExpand', [
      state('collapsed', style({height: '0px', minHeight: '0'})),
      state('expanded', style({height: '*'})),
      transition('expanded <=> collapsed', animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')),
    ]),
  ]
})
export class MygoalsComponent implements OnInit {

  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private goalService: GoalService, private taskService: TaskService, private squadService: SquadService, public dialog: MatDialog) { }



  squads: Squad[] = []
  loggedIn = new User()
  // newSquad: Squad = new Squad();
  updatedSquad: Squad = new Squad();
  selectedSquad: Squad | null = null;
  selectedMember: User | null = null;
  squadImage: Image = new Image();
  addSquad: boolean = false;
  squadNameUnique: boolean = true;
  editSquad: boolean = false;
  addmember: boolean = false;
  newMember: User = new User;
  userName: string = "";
  goals: Goal[] = [];
  columnsToDisplay = ["name", "numActiveGoals"];
  columnsToDisplayWithExpand = [...this.columnsToDisplay, 'expand'];
  expandedElement: Squad | null = null;
  updateGoal = false;
  goalToUpdate = {} as Goal;
  squadToEditId: number = 0;
  newGoal: Goal = new Goal();
  addGoal: boolean = false;
  squadId: number = 0;

  ngOnInit(): void {
    this.load();
  }

  openAddDialog(enterAnimationDuration: string, exitAnimationDuration: string): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(AddGoalDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: this.squads
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.createGoal(result.createGoalForm, result.squadId);
      }

    });
  }

  openDeleteDialog(enterAnimationDuration: string, exitAnimationDuration: string, goal: Goal): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: goal.title
    });

    dialogRef.afterClosed().subscribe((result) => {
      console.log(result);
      console.log("DELETE? " + result);
      if (result) {
        this.delete(goal.id);
      }
    });
  }

  openEditDialog(enterAnimationDuration: string, exitAnimationDuration: string, goal: Goal): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(EditGoalDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: goal
    });

    dialogRef.afterClosed().subscribe((result) => {
      this.doUpdateGoal(result);
    });
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

    this.goalService.createGoal(goal, squadId).subscribe({

      next: (result) => {
        this.newGoal = new Goal();
        // this.goalService.addSquadToGoal(result.id, squadId).subscribe({
        //   next: () => {
            this.load();
        //   },
        //   error: (nojoy) => {
        //      console.error('error creating goal:');
        //     console.error(nojoy);
        //   }
        // });
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

