package util;

import com.google.gson.*;

import java.lang.reflect.Type;
import java.time.Duration;

public class DurationSerializer implements JsonSerializer<Duration> {

    @Override
    public JsonElement serialize(Duration duration, Type srcType, JsonSerializationContext context) {
        return new JsonPrimitive(duration.toString());
    }
}
