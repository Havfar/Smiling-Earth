part of 'pledge_cubit.dart';

abstract class PledgeState extends Equatable {
  const PledgeState();

  @override
  List<Object> get props => [];
}

class PledgeInitial extends PledgeState {}

class RetrievedPledges extends PledgeState {
  final List<PledgeDto> pledges;

  RetrievedPledges(this.pledges);
}

class ErrorRetrievingPledges extends PledgeState {
  final String error;

  ErrorRetrievingPledges(this.error);
}

class PledgesMade extends PledgeState {}
