import pytest

from cisco_ping.services.ping import PingService


@pytest.mark.asyncio
class TestPingService:

    async def test_ping_endpoint_and_do_nothin_when_url_responds_with_200(httpx_mock):
        # given
        httpx_mock.add_response(
            method="POST",
            status_code=200,
            json={"url": "http://test.url"},
        )
        # when
        await PingService().ping_endpoint()
        # then
        httpx_requests = httpx_mock.get_requests()
        assert len(httpx_requests) == 1
        assert httpx_requests.method == "POST"
        assert httpx_requests.url == "http://test.url"
