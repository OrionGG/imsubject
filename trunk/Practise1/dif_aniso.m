% DIF_ANISO - Difusion Anisotrópica
%
% Usage:
%  imdif = dif_aniso(im, niter, k, lambda, opcion)
%
% Parámetros:
%         im     - imagen de entrada
%         niter  - numero de iteraciones.
%         k - Coeficiente de conductancia
%         lambda - valor máximo de 0.25 para que sea estable
%         opcion - 1 Funcion 1 de Perona Malik 
%                  2 Funcion 2 de Perona Malik
%
% Returns:
%         imdif   - imagen filtrada
%
% kappa controls conduction as a function of gradient.  If kappa is low
% small intensity gradients are able to block conduction and hence diffusion
% across step edges.  A large value reduces the influence of intensity
% gradients on conduction.
%
% lambda controla la velocidad de difusión
%
% La función de difusión 1 favorece lo bordes de alto contraste sobre los
% de bajo contraste
% LA función de difusión 2 favorece las regiones grandes sobre las pequeñas

% Referencia: 
% P. Perona and J. Malik. 
% Scale-space and edge detection using ansotropic diffusion.
% IEEE Transactions on Pattern Analysis and Machine Intelligence, 
% 12(7):629-639, July 1990.
%
% 

function imdif = dif_aniso(im, niter, k, lambda, opcion)


im = double(im);
[rows,cols] = size(im);
imdif = im;
  
for i = 1:niter
  fprintf('\rIteración %d',i);

  % Añado un marco de ceros a la imagen
  
  imdifm = zeros(rows+2, cols+2);
  imdifm(2:rows+1, 2:cols+1) = imdif;

  % Diferencias en las cuatro direcciones
  
  deltaN = imdifm(1:rows,2:cols+1)   - imdif;
  deltaS = imdifm(3:rows+2,2:cols+1) - imdif;
  deltaE = imdifm(2:rows+1,3:cols+2) - imdif;
  deltaW = imdifm(2:rows+1,1:cols)   - imdif;

  % Conductancia

  if opcion == 1
    cN = exp(-(deltaN/k).^2);
    cS = exp(-(deltaS/k).^2);
    cE = exp(-(deltaE/k).^2);
    cW = exp(-(deltaW/k).^2);
  elseif opcion == 2
    cN = 1./(1 + (deltaN/k).^2);
    cS = 1./(1 + (deltaS/k).^2);
    cE = 1./(1 + (deltaE/k).^2);
    cW = 1./(1 + (deltaW/k).^2);
  end

  imdif = imdif + lambda*(cN.*deltaN + cS.*deltaS + cE.*deltaE + cW.*deltaW);

%  Las siguientes líneas permiten ver la progresión de las imágenes

  %subplot(ceil(sqrt(niter)),ceil(sqrt(niter)), i)
  %imagesc(imdif), colormap(gray), axis image

end
end


