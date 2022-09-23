export class ReviewId {
  goalId: number = 0;
  userId: number = 0;

  constructor(
    goalId: number = 0,
    userId: number = 0
  ) {
  this.goalId = goalId;
  this.userId = userId;
  }
}
