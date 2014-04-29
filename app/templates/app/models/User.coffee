mongoose = require("mongoose")
Schema = mongoose.Schema


UserSchema = new Schema(
	name : String
	email : String
	phone : String
	address : String
)

mongoose.model("User", UserSchema)