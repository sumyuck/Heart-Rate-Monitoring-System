function [peakX] = piece_filtering(sig, sampling_rate, peaks)
    x_acceleration = band_pass(sig(3,:),sampling_rate);
    y_acceleration = band_pass(sig(4,:),sampling_rate);
	z_acceleration = band_pass(sig(5,:),sampling_rate);
	PPG_average = .5*(band_pass(sig(1,:),sampling_rate)+band_pass(sig(2,:),sampling_rate)); %averaging both channels	
	filtered_signal = adaptive_filter(PPG_average,x_acceleration,y_acceleration,z_acceleration);
	L = length(filtered_signal);
	[peakY,peakX] = fft_helper(filtered_signal, sampling_rate);
	% disp(L);
	peakX = peakX(1);
	peak = peakX;	
	f = sampling_rate*(0:(L/2))/L;
	N = 60 * sampling_rate;
	f = 60 * sampling_rate * [ 0 : 1 :N- 1 ]./N;
	Y_clean = abs(fft(filtered_signal ,N)).^2;
 %    if(length(peaks) > 3)
 %    	peak = 0.9*peak + 0.05*peaks(end) + 0.05*peaks(end-1);
	% end
end
