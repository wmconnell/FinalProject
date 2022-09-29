import { Image } from './../../models/image';
import { Component, LOCALE_ID, OnInit, ViewChild } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Squad } from 'src/app/models/squad';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { SquadService } from 'src/app/services/squad.service';
import { UserService } from 'src/app/services/user.service';
import { Goal } from 'src/app/models/goal';
import { NgForm } from '@angular/forms';
import { animate, state, style, transition, trigger } from '@angular/animations';
import { ActiveGoalsPipe } from 'src/app/pipes/active-goals.pipe';
import { MatDialog } from '@angular/material/dialog';
import { MatTable, MatTableDataSource } from '@angular/material/table';
import { MatMenuTrigger } from '@angular/material/menu';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { DeleteConfirmationDialogComponent } from '../delete-confirmation-dialog/delete-confirmation-dialog.component';
import { EditSquadDialogComponent } from '../edit-squad-dialog/edit-squad-dialog.component';
import { AddSquadDialogComponent } from '../add-squad-dialog/add-squad-dialog.component';
import { EditGoalDialogComponent } from '../edit-goal-dialog/edit-goal-dialog.component';

@Component({
  selector: 'app-squad',
  templateUrl: './squad.component.html',
  styleUrls: ['./squad.component.css'],
  animations: [
    trigger('detailExpand', [
      state('collapsed', style({height: '0px', minHeight: '0'})),
      state('expanded', style({height: '*'})),
      transition('expanded <=> collapsed', animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')),
    ]),
  ]
})
export class SquadComponent implements OnInit {
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
  columnsToDisplay = ["name", "leader", "numActiveGoals"];
  columnsToDisplayWithExpand = [...this.columnsToDisplay, 'expand'];
  expandedElement: Squad | null = null;
  updateGoal = false;
  goalToUpdate = {} as Goal;
  squadToEditId: number = 0;
  displayedColumns: string[] = ['name', 'leaderName', 'numMembers', 'actions'];
  dataSource = new MatTableDataSource(this.squads);


  @ViewChild('menuTrigger') menuTrigger!: MatMenuTrigger;
  @ViewChild(MatTable) squadTable!: MatTable<any>;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;


  constructor(
    private userService: UserService,
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute,
    private goalService: GoalService,
    private squadService: SquadService,
    private activeGoalsPipe: ActiveGoalsPipe,
    public dialog: MatDialog) { }

  ngOnInit(): void {
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user) => {
          this.loggedIn = user;
          console.log(user.username);
        },
        error: (err) => {
          console.error("Unable to retrieve user: " + err);
        }
      }
    );
    this.load()
  }

  openAddDialog(enterAnimationDuration: string, exitAnimationDuration: string): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(AddSquadDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: this.squads
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        let squad: Squad = result.createNewSquadForm.value;
        squad.profilePic = result.squadImage;
        this.createSquad(squad);
      }

    });
  }

  openDeleteSquadDialog(enterAnimationDuration: string, exitAnimationDuration: string, squad: Squad): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: squad.name
    });

    dialogRef.afterClosed().subscribe((result) => {
      console.log("DELETE? " + result);
      if (result) {
        this.deleteSquad(squad.id);
      }
    });
  }

  openDeleteGoalDialog(enterAnimationDuration: string, exitAnimationDuration: string, goal: Goal): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(DeleteConfirmationDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: goal.title
    });

    dialogRef.afterClosed().subscribe((result) => {
      console.log("DELETE? " + result);
      if (result) {
        this.deleteGoal(goal.id);
      }
    });
  }

  openEditSquadDialog(enterAnimationDuration: string, exitAnimationDuration: string, squad: Squad): void {
    // let confirmed: boolean = false;
    const dialogRef = this.dialog.open(EditSquadDialogComponent, {
      enterAnimationDuration,
      exitAnimationDuration,
      data: squad
    });

    dialogRef.afterClosed().subscribe((result) => {
      this.updateSquad(result.form, result.squadId);
    });
  }

  openEditGoalDialog(enterAnimationDuration: string, exitAnimationDuration: string, goal: Goal): void {
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

  load = () => {
    console.log("load called");
    let getTheGoals = this.getGoalsBySquad;
    this.squadService.squadsByUser().subscribe({
      next: (squads) => {
        console.log("INDEX SUCCESSFUL");
        squads.forEach(function(squad) {
          getTheGoals(squad);
        })
        this.squads = squads;
      },
      error: (err) => {
        console.error(err);
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

  select(id: number) {
    this.squadService.show(id).subscribe({
      next: (squad) => {
        this.selectedSquad = squad;
      },
      error: (err) => {
        console.error(err);
      }
    })
  }

  selectMember(userName: string) {
    this.userService.showUser(userName).subscribe({
      next: (user) => {
        console.log(user);

        this.selectedMember = user;
      },
      error: (err) => {
        console.error(err);

      }
    })
  }

  checkSquadName(form: NgForm) {
    // this.newSquad.users.push(this.loggedIn)
    // console.log(this.loggedIn);
    // console.log(this.loggedIn.id);
    // this.newSquad.leader = this.loggedIn
    // this.newSquad.profilePic = this.squadImage;
    let tempSquad = {} as Squad;
    tempSquad.name = form.value.name;
    this.squadService.existsByName(tempSquad).subscribe({
      next: (exists) => {
        if (!exists) {
          this.squadNameUnique = true;
          let newSquad = {} as Squad;
          newSquad.name = form.value.name;
          newSquad.bio = form.value.bio;
          newSquad.profilePic = this.squadImage;
          this.createSquad(newSquad);
        } else {
          this.squadNameUnique = false;
        }
    }
    });
  }

  createSquad = (squad: Squad) => {
    this.squadService.createSquad(squad).subscribe({
      next: (result) => {

        this.displayTable()
        this.load();
      },
      error: (nojoy) => {
        console.error('Error creating squad');
        console.error(nojoy);
      },
    });
  }

  displayTable() {
    this.addSquad = false
    this.selectedSquad = null;
    this.addmember = false;
    this.editSquad = false;
  }

  addMember(userName: string) {
    console.log(userName);

    this.userService.showUser(userName).subscribe({
      next: (user) => {
        this.newMember = user;
        if (this.selectedSquad) {
          this.selectedSquad!.users.push(this.newMember);
          let squadId: number = this.selectedSquad!.id;
          let memberId: number = this.newMember!.id;
          this.squadService.addMember(squadId, memberId).subscribe({
            next: (squad) => {
              this.newMember = new User();
              this.load();
            },
            error: (err) => {
              console.error(err);
            }
          })
        }
      },
      error: (err) => {
        console.log(err);

      }
    });
  }

  removeMember(userName: string) {
    console.log(userName);

    this.userService.showUser(userName).subscribe({
      next: (user) => {
        this.newMember = user;
        if (this.selectedSquad) {
          this.selectedSquad!.users.push(this.newMember);
          let squadId: number = this.selectedSquad!.id;
          let memberId: number = this.newMember!.id;
          this.squadService.removeMember(squadId, memberId).subscribe({
            next: (squad) => {
              this.newMember = new User();
              this.load();
            },
            error: (err) => {
              console.error(err);
            }
          })
        }
      },
      error: (err) => {
        console.log(err);

      }
    });
  }

  deleteSquad(id: number) {
    console.log(id);

    this.squadService.deleteSquad(id).subscribe({
      next: (squad) => {
        this.displayTable();
        this.load();
      },
      error: (err) => {
        console.error(err);
    }
  })
}

deleteGoal = (id: number): void => {
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

updateSquad(form: NgForm, id:number){
  // let id = this.loggedIn.id;
  console.log("In Update Squad Call! BEFORE HTTP");
  console.log(form.value);
  this.squadService.updateSquad(form.value,id).subscribe({
    next:(squad) =>{
      console.log("In Update Squad HTTP Call!");
      this.displayTable();
      this.load();
  },
  error:(err) =>{
    console.error(err);

      }
    })
  }

  getGoalsBySquad = (squad:Squad): void => {
    this.goalService.getGoalsBySquad(squad.id).subscribe({
      next: (result) => {
        squad.goals = result;
      },
      error: (err) => {
        console.error(err);
      }
    });
  }
}
