package site.dearmysanta.domain.mountain;
public class CoordinateConverter {

    public static class LamcParameter {
        public double Re;  // 사용할 지구반경 [km]
        public double grid;  // 격자간격 [km]
        public double slat1;  // 표준위도 [degree]
        public double slat2;  // 표준위도 [degree]
        public double olon;  // 기준점의 경도 [degree]
        public double olat;  // 기준점의 위도 [degree]
        public double xo;  // 기준점의 X좌표 [격자거리]
        public double yo;  // 기준점의 Y좌표 [격자거리]
        public boolean first;  // 시작여부 (false = 시작)
        
        public LamcParameter() {
            Re = 6371.00877; // 지도반경
            grid = 5.0; // 격자간격 (km)
            slat1 = 30.0; // 표준위도 1
            slat2 = 60.0; // 표준위도 2
            olon = 126.0; // 기준점 경도
            olat = 38.0; // 기준점 위도
            xo = 210 / grid; // 기준점 X좌표
            yo = 675 / grid; // 기준점 Y좌표
            first = false;
        }
    }

    public static class LambertProjection {

        private static final double PI = Math.asin(1.0) * 2.0;
        private static final double DEGRAD = PI / 180.0;
        private static final double RADDEG = 180.0 / PI;

        private double re, olon, olat, sn, sf, ro;

        public void lamcproj(double lon, double lat, double[] x, double[] y, int code, LamcParameter map) {
            double slat1, slat2, alon, alat, xn, yn, ra, theta;

            if (!map.first) {
                re = map.Re / map.grid;
                slat1 = map.slat1 * DEGRAD;
                slat2 = map.slat2 * DEGRAD;
                olon = map.olon * DEGRAD;
                olat = map.olat * DEGRAD;

                sn = Math.tan(PI * 0.25 + slat2 * 0.5) / Math.tan(PI * 0.25 + slat1 * 0.5);
                sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
                sf = Math.tan(PI * 0.25 + slat1 * 0.5);
                sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
                ro = Math.tan(PI * 0.25 + olat * 0.5);
                ro = re * sf / Math.pow(ro, sn);
                map.first = true;
            }

            if (code == 0) { // 위경도 -> (X,Y)
                ra = Math.tan(PI * 0.25 + lat * DEGRAD * 0.5);
                ra = re * sf / Math.pow(ra, sn);
                theta = lon * DEGRAD - olon;
                if (theta > PI) theta -= 2.0 * PI;
                if (theta < -PI) theta += 2.0 * PI;
                theta *= sn;
                x[0] = ra * Math.sin(theta) + map.xo;
                y[0] = ro - ra * Math.cos(theta) + map.yo;
            }
        }
    }

    public static int[] convertLatLonToXY(double latitude, double longitude) {
        LamcParameter map = new LamcParameter();
        LambertProjection lp = new LambertProjection();

        double[] x = new double[1];
        double[] y = new double[1];

        lp.lamcproj(longitude, latitude, x, y, 0, map);
        
        x[0] = x[0]+1.5;
        y[0] = y[0]+1.5;

        System.out.println("::" + x[0] + " " + y[0]);
        return new int[]{(int)(Math.round(x[0])), (int)(Math.round(y[0]))};
    }

}
