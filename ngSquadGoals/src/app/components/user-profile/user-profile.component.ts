import { AuthService } from './../../services/auth.service';
import { SquadService } from 'src/app/services/squad.service';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { Squad } from 'src/app/models/squad';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {
  selectedMember: User | null = null;
  userName: string | null = null;
  selectedSquad: Squad | null = null;
  loggedIn: User | null = null;
  squadMemberIds: number[] = [];

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute,
    private userService: UserService,
    private squadService: SquadService) { }

  ngOnInit(): void {
    this.selectedMember = null;
    this.userName = null;
    this.selectedSquad = null;

    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        this.loggedIn = user;
        console.log(user);
        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );

    // Get username route parameter
    this.userName = this.route.snapshot.paramMap.get("username");

    // Get selectedMember
    if (this.userName) {
      this.userService.showUser(this.userName).subscribe({
        next: (user) => {
          this.selectedMember = user;
        },
        error: (err) => {
          console.log(err);
        }
      });

      // Get selectedSquad
      let squadId: number = Number(this.route.snapshot.paramMap.get("squadId"));
      let idList = this.squadMemberIds;
      this.squadService.show(squadId).subscribe({
        next: (squad) => {
          this.selectedSquad = squad;
          squad.users.forEach(function(user) {
            if (user.id) {
              idList.push(user.id);
            }
          })
          console.log(squad.users);
        },
        error: (err) => {
          console.log(err);
        }
      });
    }
  }

  removeMember = (userName: string) => {
    let thisMember = this.selectedMember;
    let thisSquad = this.selectedSquad;
        if (thisSquad) {
          thisSquad.users.forEach(function(member, index, array) {
            if (member.id === thisMember!.id) {
              array.splice(index, 1);
            }
          });

          let squadId: number = thisSquad!.id;
          let memberId: number = thisMember!.id;
          this.squadService.removeMember(squadId, memberId).subscribe({
            next: (squad) => {
              // this.router.navigateByUrl("/squad");
              this.back();
            },
            error: (err) => {
              console.error(err);
            }
          });
        }
    }

    back = () => {
      this.router.navigateByUrl(this.route.snapshot.paramMap.get("backRoute") as string);
    }
}
