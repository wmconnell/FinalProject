import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Squad } from 'src/app/models/squad';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-remove-user-from-squad-dialog',
  templateUrl: './remove-user-from-squad-dialog.component.html',
  styleUrls: ['./remove-user-from-squad-dialog.component.css']
})
export class RemoveUserFromSquadDialogComponent implements OnInit {
  remove: boolean = false;
  constructor(public dialogRef: MatDialogRef<RemoveUserFromSquadDialogComponent>, @Inject(MAT_DIALOG_DATA) public data: {squad: Squad, member: User})  {}

  ngOnInit(): void {
  }

  closeDialog() {
    this.dialogRef.close(this.remove);
  }
}
