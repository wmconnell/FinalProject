import { SquadService } from 'src/app/services/squad.service';
import { GoalService } from './../../services/goal.service';
import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Goal } from 'src/app/models/goal';
import { Squad } from 'src/app/models/squad';
import { MatIconModule } from '@angular/material/icon';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
  loggedIn: User = new User();
  updatedUser: User = new User();
  squads: Squad[] = [];
  editUser:boolean = false;

  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private squadService: SquadService) { }

  ngOnInit(): void {
    this.load();
  }

  load = (): void => {
    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        this.loggedIn = user;
        this.loadSquads
        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
  }

deleteUser(id: number){
  this.userService.deleteUser(id).subscribe({
    next:(user)=>{
      this.logout()
    },
    error: (err) =>{
      console.error(err);

    }
  })
}
updateUser(form: NgForm){
  // console.log(id);

  // user.id = id;
  // console.log(user.id);
  console.log(form.value);
  this.userService.updateUser(form.value, form.value.id).subscribe({
    next:(user) =>{
      this.load();
    },
    error: (err) =>{
      console.error(err);

    }

  })
}
logout(){
  this.auth.logout()
  this.router.navigateByUrl('home')
  }
loadSquads() {
    console.log("load called");

    this.squadService.index().subscribe({
      next: (squad) => {
        this.squads = squad;
        // console.log(this.squads.length);
      },
      error: (err) => {
        console.error(err);

      }
    });
  }
}
