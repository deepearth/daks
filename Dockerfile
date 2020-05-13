FROM python:3.6

RUN apt-get update && apt-get install -y -q \
    mpich \
    libmpich-dev

ADD ./requirements.txt /app/requirements.txt
ADD ./requirements-optional.txt /app/requirements-optional.txt
ADD ./setup.py /app/setup.py
ADD ./versioneer.py /app/versioneer.py
ADD ./setup.cfg /app/setup.cfg

RUN python3 -m venv /venv && \
    /venv/bin/pip install --no-cache-dir --upgrade pip && \
    /venv/bin/pip install --no-cache-dir jupyter bokeh && \
    /venv/bin/pip install --no-cache-dir -r /app/requirements.txt && \
    /venv/bin/pip install --no-cache-dir -r /app/requirements-optional.txt && \
    /venv/bin/pip install --no-cache-dir -e /app

ADD ./devito /app/devito
ADD ./tests /app/tests
ADD ./examples /app/examples
ADD ./benchmarks /app/benchmarks
COPY setup.cfg /app/

ADD docker/run-jupyter.sh /jupyter
ADD docker/run-tests.sh /tests
ADD docker/run-print-defaults.sh /print-defaults
ADD docker/entrypoint.sh /docker-entrypoint.sh

RUN chmod +x \
    /print-defaults \
    /jupyter \
    /tests \
    /docker-entrypoint.sh

WORKDIR /app

ENV DEVITO_ARCH="gcc"
ENV DEVITO_OPENMP="1"

EXPOSE 8888
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/jupyter"]
