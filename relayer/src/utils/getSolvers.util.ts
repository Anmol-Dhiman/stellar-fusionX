import Solver from '../Model/solver.model';

export const getSolvers = async () => {
  try {
    const solvers = await Solver.find();
    return solvers;
  } catch (err: any) {
    return { error: err.message };
  }
};