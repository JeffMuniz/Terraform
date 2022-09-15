 # To do 
Ferramentas para SO
gcloud settings
Deploy gke terraform
login docker
crate registry and image
Deploy app container

# Start Houston we have a Go!
gcloud init
gcloud config get-value project
choco install terraform minikube gcloudsdk docker-desktop -y
# FromCloud SDK
gcloud auth application-default login
gcloud projects create gke-devops-07
gcloud config set accessibility/screen_reader true
gcloud config set project machina-357019
gke-devops-07
gcloud config set compute/zone us-central1-a-a
gcloud artifacts repositories create hello-repo --repository-format=docker --location=us-central1 --description="Docker repository"

terraform init
terraform apply --var-file dev.tfvars -auto-approve 

+
# Deploy app de um jeito moderno

# Configure kubectl
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)



kubectl get nodes
gcloud container clusters get-credentials hello-cluster --zone us-central1
kubectl create deployment hello-app --image= us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v1
kubectl scale deployment hello-app --replicas=3
kubectl autoscale deployment hello-app --cpu-percent=80 --min=1 --max=5
kubectl expose deployment hello-app --name=hello-app-service --type=LoadBalancer --port 80 --target-port 8080
kubectl get service




Via docker

cd hello-app
docker build -t  us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v1 .
docker run --rm -p 8080:8080  us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v1










curl http://localhost:8080






kubectl get nodes
gcloud container clusters get-credentials hello-cluster --zone COMPUTE_ZONE
kubectl create deployment hello-app --image= us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v1
kubectl scale deployment hello-app --replicas=3
kubectl autoscale deployment hello-app --cpu-percent=80 --min=1 --max=5
kubectl expose deployment hello-app --name=hello-app-service --type=LoadBalancer --port 80 --target-port 8080
kubectl get service


update app

Atualize a função hello() no arquivo main.go para relatar a nova versão 2.0.0.
Crie e atribua uma tag à nova imagem do Docker hello-app.
docker build -t  us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v2 .
Envie a imagem para o Artifact Registry
docker push  us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v2
kubectl set image:
kubectl set image deployment/hello-app hello-app= us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v2
kubectl get pods





delete all

kubectl delete service hello-app-service
terraform destroy --var-file dev.tfvars -auto-approve


gcloud compute networks list

gcloud compute networks delete machina-357019-vpc default



gcloud container clusters delete hello-cluster --zone COMPUTE_ZONE
gcloud artifacts docker images delete  us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v1 --delete-tags --quiet
gcloud artifacts docker images delete  us-central1-a-docker.pkg.dev/machina-357019/hello-repo/hello-app:v2 --delete-tags --quiet




gcloud projects list

gcloud projects delete machina-357019













Deploy Dash




»Deploy and access Kubernetes Dashboard
While you can deploy the Kubernetes dashboard using Terraform, kubectl is used in this tutorial so you don't need to configure your Terraform Kubernetes Provider.
The following command will schedule the resources necessary for the dashboard.
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml





»Configure kubectl
gcloud container clusters get-credentials $(terraform output -raw machina-357019-gke) -- us-central1-a-a $(terraform output -raw  us-central1-a-a)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
kubectl proxy
http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-gke-cluster/main/kubernetes-dashboard-admin.rbac.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')


»(Optional) GKE nodes and node pool
On the Dashboard UI, click Nodes on the left hand menu.

Notice there are 6 nodes in your cluster, even though gke_num_nodes in your gke.tf file was set to 2. This is because a node pool was provisioned in each of the three zones within the  us-central1-a-a to provide high availability.

gcloud container clusters describe dos-terraform-edu-gke -- us-central1-a-a  us-central1-a-a --format='default(locations)'
locations:
-  us-central1-a-a-b
-  us-central1-a-a-f
-  us-central1-a-a-c


NOTE Replace 
dos-terraform-edu-gke with the kubernetes_cluster_name value from your Terraform output.




<br> 


# Windows ajudante
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

</br>