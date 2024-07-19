# Server

## Containers

```console
docker compose up --build
```

## Monitoring

To monitor the number of active threads:

```console
$ ./open_bash_in_slurm_container.sh 

root@slurm:/home/admin# ./monitor_threads.sh 

[Tue May 21 07:44:49 UTC 2024] Active threads: 46
[Tue May 21 07:44:50 UTC 2024] Active threads: 46
...
```

# Client

## Preliminary steps

```console

$ ./0_setup_venv.sh 

Collecting fractal-client
  Using cached fractal_client-2.0.0-py3-none-any.whl (24 kB)
Collecting packaging<24.0,>=23.1
  Using cached packaging-23.2-py3-none-any.whl (53 kB)
Collecting python-dotenv<2.0.0,>=1.0.0
  Using cached python_dotenv-1.0.1-py3-none-any.whl (19 kB)
Collecting httpx<0.28.0,>=0.27.0
  Using cached httpx-0.27.0-py3-none-any.whl (75 kB)
Collecting PyJWT<3.0.0,>=2.8.0
  Using cached PyJWT-2.8.0-py3-none-any.whl (22 kB)
Collecting sniffio
  Using cached sniffio-1.3.1-py3-none-any.whl (10 kB)
Collecting httpcore==1.*
  Using cached httpcore-1.0.5-py3-none-any.whl (77 kB)
Collecting anyio
  Using cached anyio-4.3.0-py3-none-any.whl (85 kB)
Collecting certifi
  Using cached certifi-2024.2.2-py3-none-any.whl (163 kB)
Collecting idna
  Using cached idna-3.7-py3-none-any.whl (66 kB)
Collecting h11<0.15,>=0.13
  Using cached h11-0.14.0-py3-none-any.whl (58 kB)
Collecting typing-extensions>=4.1
  Using cached typing_extensions-4.11.0-py3-none-any.whl (34 kB)
Collecting exceptiongroup>=1.0.2
  Using cached exceptiongroup-1.2.1-py3-none-any.whl (16 kB)
Installing collected packages: typing-extensions, sniffio, python-dotenv, PyJWT, packaging, idna, h11, exceptiongroup, certifi, httpcore, anyio, httpx, fractal-client
Successfully installed PyJWT-2.8.0 anyio-4.3.0 certifi-2024.2.2 exceptiongroup-1.2.1 fractal-client-2.0.0 h11-0.14.0 httpcore-1.0.5 httpx-0.27.0 idna-3.7 packaging-23.2 python-dotenv-1.0.1 sniffio-1.3.1 typing-extensions-4.11.0

$ . activate_venv.sh 

(venv) $ ./1_setup_user_and_tasks.sh 

{
  "data": {
    "info": "Collecting tasks in the background. GET /task/collect/1 to query collection status",
    "log": null,
    "package": "fractal_tasks_mock",
    "status": "pending",
    "task_list": [],
    "venv_path": ".fractal/fractal-tasks-mock0.0.1"
  },
  "id": 1,
  "timestamp": "2024-05-21T07:41:37.418596+00:00"
}
Task collection started
Now edit the user's properties
{
  "cache_dir": "/tmp/fractal-test01-cache/",
  "email": "admin@fractal.xy",
  "id": 1,
  "is_active": true,
  "is_superuser": true,
  "is_verified": true,
  "slurm_accounts": [],
  "slurm_user": "test01",
  "username": "admin"
}
Done
```

## Stress test

```console
$ ./2_prepare_submissions.sh some-unique-label

Now process PROJECT=Project label-some-unique-label/1
1
2
fractal --batch job submit 1 1 1

Now process PROJECT=Project label-some-unique-label/2
.3
/4
fractal --batch job submit 2 2 2

Now process PROJECT=Project label-some-unique-label/3
3	5
6
fractal --batch job submit 3 3 3

Now process PROJECT=Project label-some-unique-label/4
7
8
fractal --batch job submit 4 4 4

Now process PROJECT=Project label-some-unique-label/5
9
10
fractal --batch job submit 5 5 5

Now process PROJECT=Project label-some-unique-label/6
11
12
fractal --batch job submit 6 6 6

Now process PROJECT=Project label-some-unique-label/7
13
14
fractal --batch job submit 7 7 7

Now process PROJECT=Project label-some-unique-label/8
15
16
fractal --batch job submit 8 8 8

Now process PROJECT=Project label-some-unique-label/9
17
18
fractal --batch job submit 9 9 9

Now process PROJECT=Project label-some-unique-label/10
19
20
fractal --batch job submit 10 10 10

(venv) $ ./3_submit_jobs.sh 
1
2
3
4
5
6
7
8
9
10
```
