package wines.myapplication;

/**
 * Created by wines on 11/3/17.
 */

public class hiroDevice {
    private String device_name;
    private String device_uuid;
    private boolean is_connected;

    public hiroDevice(String name, String uuid, boolean connect_status) {
        this.device_uuid = uuid;
        this.device_name = name;
        this.is_connected = connect_status;
    }

    public String getDeviceName() {
        return this.device_name;
    }

    public String getDeviceUuid(){
        return this.device_uuid;
    }

    public void setIsConnected(boolean connect_status) {
        this.is_connected = connect_status;
    }

    public boolean isConnected(){
        return this.is_connected;
    }
}
