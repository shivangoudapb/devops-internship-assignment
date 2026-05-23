import os
from iii import InitOptions, Logger, register_worker

iii = register_worker(
    os.environ.get("III_URL", "ws://localhost:49134"),
    InitOptions(worker_name="mock-worker"),
)

logger = Logger()

def run_inference_handler(payload):
    messages = payload.get("messages", [])

    user_message = ""
    if messages:
        user_message = messages[-1].get("content", "")

    logger.info(f"Received message: {user_message}")

    return {
        "response": f"Mock inference response for: {user_message}",
        "status": "success"
    }

iii.register_function(
    "inference::run_inference",
    run_inference_handler
)

print("Mock inference worker started")