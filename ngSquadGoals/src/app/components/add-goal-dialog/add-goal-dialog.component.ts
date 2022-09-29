import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Goal } from 'src/app/models/goal';
import { Squad } from 'src/app/models/squad';

@Component({
  selector: 'app-add-goal-dialog',
  templateUrl: './add-goal-dialog.component.html',
  styleUrls: ['./add-goal-dialog.component.css']
})
export class AddGoalDialogComponent implements OnInit {
  squadId: number | null = null;

  constructor(public dialogRef: MatDialogRef<AddGoalDialogComponent>, @Inject(MAT_DIALOG_DATA) public data: Squad[])  {}

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
