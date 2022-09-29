import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Goal } from 'src/app/models/goal';

@Component({
  selector: 'app-edit-goal-dialog',
  templateUrl: './edit-goal-dialog.component.html',
  styleUrls: ['./edit-goal-dialog.component.css']
})
export class EditGoalDialogComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<EditGoalDialogComponent>, @Inject(MAT_DIALOG_DATA) public data: Goal)  {}

  ngOnInit(): void {
  }

  myFilter = (d: Date | null): boolean => {
    const day = (d || new Date()).getDay();
    // Prevent Saturday and Sunday from being selected.
    return day !== 0 && day !== 6;
  };

  closeDialog() {
    this.dialogRef.close(this.data);
  }
}
