[Mesh]
  type = FoamMesh
  case = './foam_mesh'
  foam_patch = 'topAndBottom frontAndBack'
[]

[AuxVariables]
  [T]
    initial_condition = 111
    family = MONOMIAL
    order = CONSTANT
  []
  [foam_T]
    initial_condition = 999
    family = MONOMIAL
  []
  [foam_hf]
    initial_condition = 999
    family = MONOMIAL
  []
[]

[Problem]
  type=FoamProblem
  temp = T
  foam_temp = foam_T
  foam_heat_flux = foam_hf
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1
  dt = 1

  [TimeStepper]
    type = FoamTimeStepper
  []
[]
