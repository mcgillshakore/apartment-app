class ApplicationController < Sinatra::Base
  set :views, "app/views"

    get('/tenants_list') do 
      @all_tenants = Tenant.all
      erb :tenants_list
    end

    get('/apartments_list') do 
      @all_apartments = Apartment.all
      erb :apartments_list
    end

    get('/apartment/:id') do
      @apartment = Apartment.find(params[:id])
      @tenants = Tenant.all
      erb :apartment
  end
  
    get('/tenant/:id')do
    @all_apartments = Apartment.all
     @tenant = Tenant.find(params[:id])
     erb :tenant
    end

    get('/create_apartment_form')do
      @all_apartments
      erb :create_apartment
    end

    post('/create_apartment')do
      @apartment = Apartment.create({
        address: params[:add_address] 
      })
      redirect("/apartments_list")
    end


    get('/create_tenant_form')do
      @all_tenants
      @all_apartments = Apartment.all
      erb :create_tenant
    end

    post('/create_tenant')do
        @tenant = Tenant.create({
          name: params[:tenant_name],
          apartment_id: params[:apartment_name_id]
        })
        redirect("/tenants_list")
    end

    get('/tenants/:id/edit')do
    @all_tenants
    @all_apartments = Apartment.all
    erb :tenant
    end

    patch('/tenants/:id')do
    @all_apartments
    @tenant = Tenant.where({id: params[:id]})
    @tenant.update({
      name: params[:tenant_name],
      apartment_id: params[:apartment_name_id]
    })
    redirect('/tenants_list')
    end

    delete('/delete_apartment/:id')do
      apartment = Apartment.find(params[:id])
      apartment.destroy()
      redirect('/apartments_list')
    end
    get('/')do

    end
    delete('/delete_tenant/:id')do
      tenant = Tenant.find(params[:id])
      tenant.destroy()
      redirect('/tenants_list')
    end
end
