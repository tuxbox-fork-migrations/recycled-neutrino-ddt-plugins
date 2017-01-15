#include "current.h"

#if defined(HAVE_SPARK_HARDWARE) || defined(HAVE_DUCKBOX_HARDWARE)
void FillRect(int _sx, int _sy, int _dx, int _dy, uint32_t color)
{
	uint32_t *p1, *p2, *p3, *p4;
	sync_blitter = 1;

	STMFBIO_BLT_DATA bltData;
	memset(&bltData, 0, sizeof(STMFBIO_BLT_DATA));

	bltData.operation  = BLT_OP_FILL;
	bltData.dstOffset  = 1920 * 1080 * 4;
	bltData.dstPitch   = DEFAULT_XRES * 4;

	bltData.dst_left   = _sx;
	bltData.dst_top    = _sy;
	bltData.dst_right  = _sx + _dx - 1;
	bltData.dst_bottom = _sy + _dy - 1;

	bltData.dstFormat  = SURF_ARGB8888;
	bltData.srcFormat  = SURF_ARGB8888;
	bltData.dstMemBase = STMFBGP_FRAMEBUFFER;
	bltData.srcMemBase = STMFBGP_FRAMEBUFFER;
	bltData.colour     = color;

	if (ioctl(fb, STMFBIO_BLT, &bltData ) < 0)
		perror("RenderBox ioctl STMFBIO_BLT");
	sync_blitter = 1;
}
#endif

void RenderBox(int _sx, int _sy, int _ex, int _ey, int rad, int col)
{
	int F,R=rad,ssx=startx+_sx,ssy=starty+_sy,dxx=_ex-_sx,dyy=_ey-_sy,rx,ry,wx,wy,count;

	uint32_t *pos = lbb + ssx + stride * ssy;
	uint32_t *pos0, *pos1, *pos2, *pos3, *i;
	uint32_t pix = bgra[col];

	if (dxx<0) 
	{
		fprintf(stderr, "[%s] RenderBox called with dx < 0 (%d)\n", __plugin__, dxx);
		dxx=0;
	}

	if(R)
	{
#if defined(HAVE_SPARK_HARDWARE) || defined(HAVE_DUCKBOX_HARDWARE)
		if(sync_blitter) {
			sync_blitter = 0;
			if (ioctl(fb, STMFBIO_SYNC_BLITTER) < 0)
				perror("RenderBox ioctl STMFBIO_SYNC_BLITTER");
		}
#endif
		if(--dyy<=0)
		{
			dyy=1;
		}

		if(R==1 || R>(dxx/2) || R>(dyy/2))
		{
			R=dxx/10;
			F=dyy/10;	
			if(R>F)
			{
				if(R>(dyy/3))
				{
					R=dyy/3;
				}
			}
			else
			{
				R=F;
				if(R>(dxx/3))
				{
					R=dxx/3;
				}
			}
		}
		ssx=0;
		ssy=R;
		F=1-R;

		rx=R-ssx;
		ry=R-ssy;

		pos0=pos+(dyy-ry)*stride;
		pos1=pos+ry*stride;
		pos2=pos+rx*stride;
		pos3=pos+(dyy-rx)*stride;

		while (ssx <= ssy)
		{
			rx=R-ssx;
			ry=R-ssy;
			wx=rx<<1;
			wy=ry<<1;

			for(i=pos0+rx; i<pos0+rx+dxx-wx;i++)
				*i = pix;
			for(i=pos1+rx; i<pos1+rx+dxx-wx;i++)
				*i = pix;
			for(i=pos2+ry; i<pos2+ry+dxx-wy;i++)
				*i = pix;
			for(i=pos3+ry; i<pos3+ry+dxx-wy;i++)
				*i = pix;

			ssx++;
			pos2-=stride;
			pos3+=stride;
			if (F<0)
			{
				F+=(ssx<<1)-1;
			}
			else   
			{ 
				F+=((ssx-ssy)<<1);
				ssy--;
				pos0-=stride;
				pos1+=stride;
			}
		}
		pos+=R*stride;
	}

#if defined(HAVE_SPARK_HARDWARE) || defined(HAVE_DUCKBOX_HARDWARE)
	FillRect(startx + _sx, starty + _sy + R, dxx + 1, dyy - 2 * R + 1, pix);
#else
	for (count=R; count<(dyy-R); count++)
	{
		for(i=pos; i<pos+dxx;i++)
			*i = pix;
		pos+=stride;
	}
#endif
}

