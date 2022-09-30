import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { UserService } from './services/user.service';
import {HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatIconModule } from '@angular/material/icon';


import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RegisterComponent } from './components/register/register.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { AuthService } from './services/auth.service';
import { AboutComponent } from './components/about/about.component';
import { UserComponent } from './components/user/user.component';
import { BadgeComponent } from './components/badge/badge.component';
import { GoalComponent } from './components/goal/goal.component';
import { ImageComponent } from './components/image/image.component';
import { ReviewComponent } from './components/review/review.component';
import { SquadComponent } from './components/squad/squad.component';
import { TagComponent } from './components/tag/tag.component';
import { TaskComponent } from './components/task/task.component';
import { ActivePipe } from './pipes/active.pipe';
import { ActiveGoalsPipe } from './pipes/active-goals.pipe';
import { SquadUserPipe } from './pipes/squad-user.pipe';
import { GoalUserPipe } from './pipes/goal-user.pipe';
import { MygoalsComponent } from './components/mygoals/mygoals.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatTableModule } from '@angular/material/table';
import { PublicsquadComponent } from './components/publicsquad/publicsquad.component';
import { MatFormFieldControl, MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatMenuModule } from '@angular/material/menu';
import { DeleteConfirmationDialogComponent } from './components/delete-confirmation-dialog/delete-confirmation-dialog.component';
import { EditGoalDialogComponent } from './components/edit-goal-dialog/edit-goal-dialog.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatButtonModule } from '@angular/material/button';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { AddGoalDialogComponent } from './components/add-goal-dialog/add-goal-dialog.component';
import { EditSquadDialogComponent } from './components/edit-squad-dialog/edit-squad-dialog.component';
import { AddSquadDialogComponent } from './components/add-squad-dialog/add-squad-dialog.component';
import { MatBadgeModule } from '@angular/material/badge';
import { UserProfileComponent } from './components/user-profile/user-profile.component';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatCardModule } from '@angular/material/card';
import { TheOneComponent } from './components/the-one/the-one.component';
import { MatTooltipModule } from '@angular/material/tooltip';
import { RemoveUserFromSquadDialogComponent } from './components/remove-user-from-squad-dialog/remove-user-from-squad-dialog.component';

@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    HomeComponent,
    LoginComponent,
    LogoutComponent,
    RegisterComponent,
    NotFoundComponent,
    AboutComponent,
    UserComponent,
    BadgeComponent,
    GoalComponent,
    ImageComponent,
    ReviewComponent,
    SquadComponent,
    TagComponent,
    TaskComponent,
    ActivePipe,
    ActiveGoalsPipe,
    SquadUserPipe,
    GoalUserPipe,
    MygoalsComponent,
    PublicsquadComponent,
    DeleteConfirmationDialogComponent,
    EditGoalDialogComponent,
    AddGoalDialogComponent,
    EditSquadDialogComponent,
    AddSquadDialogComponent,
    UserProfileComponent,
    TheOneComponent,
    RemoveUserFromSquadDialogComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    MatIconModule,
    BrowserAnimationsModule,
    MatTableModule,
    MatFormFieldModule,
    MatInputModule,
    MatMenuModule,
    MatDialogModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatButtonModule,
    MatPaginatorModule,
    MatSortModule,
    MatBadgeModule,
    MatAutocompleteModule,
    ReactiveFormsModule,
    MatCardModule,
    MatTooltipModule
  ],

    providers:  [
    AuthService,
    UserService,
    ActiveGoalsPipe,
    SquadUserPipe,
    ActivePipe,
    MatDialog

    ],
  bootstrap: [AppComponent]
})
export class AppModule { }
