import math
import numpy as np
import matplotlib.pyplot as plt
from collections.abc import MutableMapping
from fractions import Fraction
from mpmath import quad
from mpl_toolkits.mplot3d import axes3d, Axes3D
from matplotlib import cm

class HierarchialDict(MutableMapping):
    def __init__(self, data={}, sub={}):
        self.mapping = data
        self.sub = sub
        
    def __getitem__(self, key):
        if key in self.mapping:
            return self.mapping[key]
        else:
            return self.sub[key]
        
    def __delitem__(self, key):
        if key in self.mapping:
            del self.mapping[key]
        else:
            del self.sub[key]
            
    def __setitem__(self, key, value):
        if key in self.mapping:
            self.mapping[key] = value
        else:
            self.sub[key] = value
        return(value)
    
    def __iter__(self):
        return iter({**self.sub, **self.mapping})
    
    def __len__(self):
        return len(self.mapping) + len(self.sub)
    
    def __repr__(self):
        return f"{self.mapping}, sub:{self.sub}"
    
    def ins(self, data):
        self.mapping={**self.mapping, **data}

        
m_vars = {
    'fpprec': 16,
    'pi': math.pi,
    'e': math.e,
    'ratepsilon': 2.0E-15
}

def plot2d(mapping, *constraints, m_vars = m_vars):
    plt.ion()
    if type(mapping) != list:
        mapping = [mapping]
    for expr in mapping:
        if len(constraints) == 1:
            X = np.arange(constraints[0][1],
                          constraints[0][2],
                          0.0001,
                          dtype = 'float')
            Y = np.array([expr(xi) for xi in X])
            plt.plot(X, Y)
    plt.draw()

def plot3d(mapping, *constraints, m_vars = m_vars):
    fig = plt.figure()
    ax = Axes3D(fig)
    plt.ion()
    if type(mapping) != list:
        mapping = [mapping]
    for expr in mapping:
        vexpr = np.vectorize(expr)
        if len(constraints) == 2:
            X = np.arange(constraints[0][1],
                          constraints[0][2],
                          0.01,
                          dtype = 'float')
            Y = np.arange(constraints[1][1],
                          constraints[1][2],
                          0.01,
                          dtype = 'float')
            X, Y = np.meshgrid(X, Y)
            Z = vexpr(X, Y)
            surf = ax.plot_surface(X, Y, Z, cmap=cm.coolwarm, linewidth=0, antialiased=False)
    plt.show()

m_funcs = {
    'sin': math.sin,
    'pow': math.pow,
    'factorial': math.factorial,
    'floor': math.floor,
    'sqrt': math.sqrt,
    'num':lambda x:x,
    'denom': lambda x:1,
    'print': print,
    'listp': lambda x: type(x) == list,
    'numberp': lambda x: (type(x) == int or
                          type(x) == float or
                          type(x) == Fraction or
                          type(x) == np.float64 or
                          type(x) == np.float128 or
                          type(x) == np.float32 or
                          type(x) == np.float16 or
                          type(x) == np.float),
    'length': len,
     # As defined in "Concrete Mathematics", Section 3.4
    'mod': lambda x,y: (x if y == 0 else x - y * math.floor(x / y)),
    'emptyp': lambda x: (True if len(x) == 0 else False),
    'first': lambda x: x[0],
    'integerp': lambda x: type(x) == int,
    'append': lambda *x: [i for l in x for i in l],
    'plot2d': plot2d,
    'plot3d': plot3d,
    'map': lambda f, i: list(map(f, i)),
    'abs': abs,
    'every': lambda func, l: all(map(func, l)),
    'quad_qagi': quad,
    'cos': math.cos,
    'float': float,
    'signum': lambda x: 0 if x==0 else x/abs(x)
}

def assign(lhs, rhs, m_vars = m_vars):
    m_vars[lhs] = rhs
    return rhs
