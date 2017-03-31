%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_imdilate���Լ�ʵ�ֵĶ�ֵ���㷨  %
%      ���룺��ά����image            %
%            ��ֵ����ֵthreshhold     %
%      �������ֵ���ľ��󣬴�С����    % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_im2bw(image,threshhold)
    % ת����double���ܽ�������
    image_double = double(image);
    
    output = zeros(size(image));
    [height width] = size(image);
    
    % ���������ֵ
    maxmum_pixel = max( max(image_double) );
    for i = 1:height
        for j = 1:width
            % ������������ ��ֵ*�������ֵ������Ϊ1
            if(image(i,j) > threshhold*maxmum_pixel)
                output(i,j) = 1;   
            % ������Ϊ0
            else
                output(i,j) = 0;
            end
        end
    end

end