%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_imdilate���Լ�ʵ�ֵ������㷨    %
%      ���룺��ά����image             %
%            ���ͺ� kernel            %
%      ��������ͺ�ľ��󣬴�С����    % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [output] = My_imdilate(image,kernel)
    % ����˵ĸߺͿ�    
    [k_height,k_width] = size(kernel);
    
    % ȡ��
    x_center = floor(k_height/2);
    y_center = floor(k_width/2);
    % ����ͼ�ĸߺͿ�
    image = padarray(image,[x_center y_center]);
 
    [new_height,new_widt] = size(image);

    % �������ͣ�������Χ��Сһ��center��ֹ����
    % ͬʱ��֤���output��ԭ����imageһ����С
    for i = x_center+1:new_height-x_center
        for j = y_center+1:new_widt-y_center
            % ȡ�����һ����С�ľ���
            samesize_bloc = image(i-x_center:i+x_center,j-y_center:j+y_center);
            % ������������˵��߼���
            andresult = kernel&samesize_bloc;
            % ���
            sum_result=sum( sum(andresult) );
            % ���ʹ���sum_result��˵��ԭ�����(i,j)���������һ������
            % ����(i,j)
            if sum_result>0
                output(i-x_center,j-y_center) = 1;
            % ���򣬴˵㲻�������ͷ�Χ
            else
                output(i-x_center,j-y_center) = 0;
            end
        end
    end
end