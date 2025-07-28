import express from 'express';

import { getAllSolvers } from '../Controller/getAllSolvers.controller';
import { registerSolver } from '../Controller/registerSolver.controller';

const router = express.Router();

// Create solver
router.post('/register', registerSolver);
// Get all solvers
router.get('/', getAllSolvers);

export default router;
