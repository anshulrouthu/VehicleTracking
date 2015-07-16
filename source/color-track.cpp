
#include <iostream>
#include "opencv/cv.h"
#include "opencv/highgui.h"
#include "opencv/cvaux.h"
#include "opencv/cxmisc.h"
#include <iomanip>
#include <math.h>
#include <string.h>
#include <time.h>

#include <stdio.h>
using namespace std;
using namespace cv;

int main(int ac, char** av)
{
	IplImage* frame;
	CvCapture* capture = cvCreateCameraCapture(-1);
	cvSetCaptureProperty(capture, CV_CAP_PROP_FRAME_WIDTH, 640);
	cvSetCaptureProperty(capture, CV_CAP_PROP_FRAME_HEIGHT, 480);
	//cvNamedWindow("Webcam Preview", CV_WINDOW_AUTOSIZE);
	//cvMoveWindow("Webcam Preview", 300, 200);

	time_t start, end;
	double fps, sec;
	int counter = 0;
	char k;

	time(&start);

	while (1)
	{
		frame = cvQueryFrame(capture);
		time(&end);
		++counter;
		sec = difftime(end, start);
		fps = counter / sec;
		printf("FPS = %.2f\n", fps);

		if (!frame)
		{
			printf("Error");
			break;
		}

		//cvShowImage("Webcam Preview", frame);

		k = cvWaitKey(10) & 0xff;
		switch (k)
		{
		case 27:
		case 'q':
		case 'Q':
			break;
		}
	}

	//cvDestroyWindow("Webcam Preview");
	cvReleaseCapture(&capture);
	return 0;
}
