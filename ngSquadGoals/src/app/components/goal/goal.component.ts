import { ActiveGoalsPipe } from './../../pipes/active-goals.pipe';
import { SquadService } from 'src/app/services/squad.service';
import { Component, OnInit, ViewChild } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { Goal } from 'src/app/models/goal';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';
import { Squad } from 'src/app/models/squad';
import { NgForm } from '@angular/forms';
import { MatTable, MatTableDataSource } from '@angular/material/table';
import { MatDialog } from '@angular/material/dialog';
import { MatMenuTrigger } from '@angular/material/menu';
import { DeleteConfirmationDialogComponent } from '../delete-confirmation-dialog/delete-confirmation-dialog.component';

@Component({
  selector: 'app-goal',
  templateUrl: './goal.component.html',
  styleUrls: ['./goal.component.css']
})
export class GoalComponent implements OnInit {

  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private goalService: GoalService, private taskService: TaskService, private squadService: SquadService, private activeGoalsPipe: ActiveGoalsPipe, public dialog: MatDialog) { }

  @ViewChild('menuTrigger')
  menuTrigger!: MatMenuTrigger;

  goals: Goal[] = [];
  displayedColumns: string[] = ['title', 'squadName', 'description', 'completed', 'endDate', 'delete'];
  dataSource = new MatTableDataSource(this.goals);

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  @ViewChild(MatTable) goalTable!: MatTable<any>;


  loggedIn: User = new User();
  squads: Squad[] = [];
  newGoal: Goal = new Goal();
  goalToUpdate: Goal = new Goal();
  updateGoal: boolean = false;
  squadName: string = '';
  addGoal: boolean = false;
  squadId: number = 0;
  tasks: Task[] =[];

  ngOnInit(): void {
    this.load();
  }

  openDialog(enterAnimationDuration: string, exitAnimationDuration: string): void {
    this.dialog.open(DeleteConfirmationDialogComponent, {
      width: '250px',
      enterAnimationDuration,
      exitAnimationDuration,
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
          this.loadGoals();

        // this.getSquads();
        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
  }



  createGoal(form: NgForm, squadId:number): void {
    let goal = form.value;
    // goal.creator = new User();
    // goal.creator.id = this.loggedIn.id;
    // goal.active = true;
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
    // let squad: Squad = new Squad();
    // console.log("This.squadId = " + this.squadId);
    // squad.id = this.squadId;
    // goal.squads = [];
    // goal.squads.push(squad);
    // console.log("This squad's ID: " + squad.id);

    this.goalService.createGoal(goal, squadId).subscribe({

      next: (result) => {
        // this.newGoal = new Goal();
        // this.goalService.addSquadToGoal(result.id, squadId).subscribe({
        //   next: () => {
            this.load();
          },
      //     error: (nojoy) => {
      //        console.error('error creating goal:');
      //       console.error(nojoy);
      //     }
      //   });
      //   // this.newGoal.creator = this.loggedIn;
      // },
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

  loadGoals(){
    this.goalService.index().subscribe(
      {
        next: (goals) => {
          console.log("******* showAllGoals func *******")
          console.log(goals)
          this.goals = goals;
          this.dataSource = new MatTableDataSource(this.activeGoalsPipe.transform(this.goals));
          this.goalTable.renderRows();
        },
        error: (err) => {
          console.error('goal.component.ts error: error loading all goals');
          console.error(err);
        }
      }
    )
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
