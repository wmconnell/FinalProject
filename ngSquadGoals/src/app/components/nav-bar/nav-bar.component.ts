import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

  constructor(private auth: AuthService,private router: Router) { }
loggedIn: User = new User();
  ngOnInit(): void {
    // this.load();
  }

  load = (): void => {
    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        this.loggedIn = user;
        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
  }

  logedIn(){
    if(this.auth.checkLogin()){
      return true
    }
    else{
      return false;
    }
  }
  logout(){
    this.auth.logout()
    this.router.navigateByUrl('/home')
  }

  isAdmin() {
    if(this.loggedIn.role === "admin"){
      return true;
    }
    else{
      return false;
    }
  }

  isNotAdmin(){


    this.auth.getLoggedInUser().subscribe(
      {
        next: (user) => {
          this.loggedIn = user;
          console.log(user.username);
          // this.squads = user.squads;


          // console.log(this.squads.length);


          // console.log("Successfully retrieved user id " + user.id);
        },
        error: (err) => {
          console.error("Unable to retrieve user: " + err);
        }
      }
      );

      if(this.loggedIn.role === "admin"){
        return true;
      }
      else{
        return false;
      }
    }
}
