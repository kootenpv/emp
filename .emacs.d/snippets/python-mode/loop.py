# -*- mode: snippet -*-
# name: loop
# key: loop
# --
import asyncio
import aiohttp

loop = asyncio.get_event_loop()


async def test():
    $0

asyncio.ensure_future()

loop.run_forever()
