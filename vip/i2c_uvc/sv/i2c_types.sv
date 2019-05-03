`ifndef I2C_TYPES_SV
 `define I2C_TYPES_SV

typedef enum {
              I2C_WRITE = 0,
              I2C_READ  = 1
              } i2c_direction_enum;

typedef enum {
	            I2C_ACK  = 0,
	            I2C_NACK = 1
              } i2c_ack_enum;

`endif

