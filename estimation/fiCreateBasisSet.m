function [ basis, score ] = fiCreateBasisSet( type, varargin )

% [ basis, score ] = fiCreateBasisSet( type, varargin )
%
% Creates a set of basis functions for spectral quantities.
%
% Inputs (required):
%    type - a string specifying the type of spectral quantity for which
%      basis functions are generated. Allowed values are {'reflectance',
%      'excitation','emission'}
%
% Inputs (optional):
%    'wave' - spectral quantities wavelength sampling (default =
%      400:10:700)
%    'n' - number of basis functions (default = 5);
%
% Outputs:
%    basis - a (w x n) array of linear basis functions, where w is the
%      number of wavelength samples.
%    score - a (n x 1) vector of variances captured by each linear basis
%      function.
%
% Copytight, Henryk Blasinski 2016


p = inputParser;
p.addRequired('type',@(x)(strcmp(x,validatestring(x,{'reflectance','excitation','emission'}))));
p.addParamValue('wave',400:10:700,@isnumeric);
p.addParamValue('n',5,@isscalar);

p.parse(type,varargin{:});
inputs = p.Results;

switch type
    case 'reflectance'
        
        fName = fullfile(isetRootPath,'data','surfaces','macbethChart');
        data = ieReadSpectra(fName,inputs.wave);

    case 'excitation'
        
        fName = fullfile(fiToolboxRootPath,'data','McNamara-Boswell');
        fluorophores = fiReadFluorophoreSet(fName,'peakEmRange',[0 max(inputs.wave)],...
                                                  'peakExRange',[min(inputs.wave) Inf],...
                                                  'wave',inputs.wave);

        data = zeros(length(inputs.wave),length(fluorophores));
        for i=1:length(fluorophores)
            data(:,i) = fluorophoreGet(fluorophores(i),'normalized excitation');
        end

    case 'emission'
        
        fName = fullfile(fiToolboxRootPath,'data','McNamara-Boswell');
        fluorophores = fiReadFluorophoreSet(fName,'peakEmRange',[0 max(inputs.wave)],...
                                                  'peakExRange',[min(inputs.wave) Inf],...
                                                  'wave',inputs.wave);

        data = zeros(length(inputs.wave),length(fluorophores));
        for i=1:length(fluorophores)
            data(:,i) = fluorophoreGet(fluorophores(i),'normalized emission');
        end   

end


[basis, ~, score] = pca(data','centered',false); 
basis = basis(:,1:inputs.n);
score = score(1:inputs.n);
end

