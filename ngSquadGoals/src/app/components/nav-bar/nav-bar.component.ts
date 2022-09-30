import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

  constructor(private auth: AuthService, private userService: UserService, private router: Router) { }
loggedIn: User = new User;
isLoggedIn: boolean = false;
  ngOnInit(): void {
    this.load();
  }

  load = (): void => {
    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        console.log(user);
        this.loggedIn = user;
        this.isLoggedIn = true;
        this.userService.show(user.id).subscribe({
          next: (result) => {
            console.log(result);
            this.loggedIn.profilePic = result.profilePic;
          },
          error: (err) => {
            console.error("Unable to retrieve user: " + err);
          }
        })

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
    this.isLoggedIn = false;
    this.auth.logout();
    this.router.navigateByUrl('/home');
    setTimeout(() => {
      window.location.reload();
    }, 1); // Activate after 5 minutes.

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
