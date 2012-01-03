<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Example extends CI_Controller
{

	/**
	 * Example::__construct()
	 *
	 */
	public function __construct()
	{
		parent::__construct();

		$this->load->library('bitauth');

		$this->load->helper('form');
		$this->load->helper('url');

		$this->load->library('form_validation');
		$this->form_validation->set_error_delimiters('<div class="error">', '</div>');
	}

	/**
	 * Example::login()
	 *
	 */
	public function login()
	{
		$data = array();

		if($this->input->post())
		{
			$this->form_validation->set_rules('username', 'Username', 'trim|required');
			$this->form_validation->set_rules('password', 'Password', 'required');
			$this->form_validation->set_rules('remember_me','Remember Me','');

			if($this->form_validation->run() == TRUE)
			{
				// Login
				if($this->bitauth->login($this->input->post('username'), $this->input->post('password'), $this->input->post('remember_me')))
				{
					// Redirect
					if($redir = $this->session->userdata('redir'))
					{
						$this->session->unset_userdata('redir');
					}

					redirect($redir ? $redir : 'example');
				}
				else
				{
					$data['error'] = $this->bitauth->get_error();
				}
			}
			else
			{
				$data['error'] = validation_errors();
			}
		}

		$this->load->view('example/login', $data);
	}

	/**
	 * Example::index()
	 *
	 */
	public function index()
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		$this->load->view('example/users', array('bitauth' => $this->bitauth, 'users' => $this->bitauth->get_users()));
	}

	/**
	* Example::register()
	*
	*/
	public function register()
	{
		if($this->input->post())
		{
			$this->form_validation->set_rules('username', 'Username', 'trim|required|bitauth_unique_username');
			$this->form_validation->set_rules('fullname', 'Fullname', '');
			$this->form_validation->set_rules('email', 'Email', 'trim|required|valid_email');
			$this->form_validation->set_rules('password', 'Password', 'required|bitauth_valid_password');
			$this->form_validation->set_rules('password_conf', 'Password Confirmation', 'required|matches[password]');

			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit'], $_POST['password_conf']);
				$this->bitauth->add_user($this->input->post());
				redirect('example/login');
			}

		}

		$this->load->view('example/add_user', array('title' => 'Register'));
	}

	/**
	* Example::add_user()
	*
	*/
	public function add_user()
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		if ( ! $this->bitauth->has_role('admin'))
		{
			$this->load->view('example/no_access');
			return;
		}

		if($this->input->post())
		{
			$this->form_validation->set_rules('username', 'Username', 'trim|required|bitauth_unique_username');
			$this->form_validation->set_rules('fullname', 'Fullname', '');
			$this->form_validation->set_rules('email', 'Email', 'trim|required|valid_email');
			$this->form_validation->set_rules('password', 'Password', 'required|bitauth_valid_password');
			$this->form_validation->set_rules('password_conf', 'Password Confirmation', 'required|matches[password]');

			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit'], $_POST['password_conf']);
				$this->bitauth->add_user($this->input->post());
				redirect('example');
			}

		}

		$this->load->view('example/add_user', array('title' => 'Add User', 'bitauth' => $this->bitauth));
	}


	/**
	* Example::edit_user()
	*
	*/
	public function edit_user($user_id)
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		if ( ! $this->bitauth->has_role('admin'))
		{
			$this->load->view('example/no_access');
			return;
		}

		if($this->input->post())
		{
			$this->form_validation->set_rules('username', 'Username', 'trim|required|bitauth_unique_username['.$user_id.']');
			$this->form_validation->set_rules('fullname', 'Fullname', '');
			$this->form_validation->set_rules('email', 'Email', 'trim|required|valid_email');
			$this->form_validation->set_rules('active', 'Active', '');
			$this->form_validation->set_rules('enabled', 'Enabled', '');
			$this->form_validation->set_rules('password_never_expires', 'Password Never Expires', '');
			$this->form_validation->set_rules('groups[]', 'Groups', '');

			if($this->input->post('password'))
			{
				$this->form_validation->set_rules('password', 'Password', 'bitauth_valid_password');
				$this->form_validation->set_rules('password_conf', 'Password Confirmation', 'required|matches[password]');
			}

			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit'], $_POST['password_conf']);
				$this->bitauth->update_user($user_id, $this->input->post());
				redirect('example');
			}

		}

		$groups = array();
		foreach($this->bitauth->get_groups() as $_group)
		{
			$groups[$_group->group_id] = $_group->name;
		}


		$this->load->view('example/edit_user', array('bitauth' => $this->bitauth, 'groups' => $groups, 'user' => $this->bitauth->get_user_by_id($user_id)));
	}

	/**
	 * Example::groups()
	 *
	 */
	public function groups()
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		$this->load->view('example/groups', array('bitauth' => $this->bitauth, 'groups' => $this->bitauth->get_groups()));
	}

	/**
	 * Example::add_group()
	 *
	 */
	public function add_group()
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		if ( ! $this->bitauth->has_role('admin'))
		{
			$this->load->view('example/no_access');
			return;
		}

		if($this->input->post())
		{
			$this->form_validation->set_rules('name', 'Group Name', 'trim|required|bitauth_unique_group');
			$this->form_validation->set_rules('description', 'Description', '');
			$this->form_validation->set_rules('members[]', 'Members', '');
			$this->form_validation->set_rules('roles[]', 'Roles', '');

			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit']);
				$this->bitauth->add_group($this->input->post());
				redirect('example/groups');
			}

		}

		$users = array();
		foreach($this->bitauth->get_users() as $_user)
		{
			$users[$_user->user_id] = $_user->fullname;
		}

		$this->load->view('example/add_group', array('bitauth' => $this->bitauth, 'roles' => $this->bitauth->get_roles(), 'users' => $users));
	}

	/**
	 * Example:edit_group()
	 *
	 */
	public function edit_group($group_id)
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		if ( ! $this->bitauth->has_role('admin'))
		{
			$this->load->view('example/no_access');
			return;
		}

		if($this->input->post())
		{
			$this->form_validation->set_rules('name', 'Group Name', 'trim|required|bitauth_unique_group['.$group_id.']');
			$this->form_validation->set_rules('description', 'Description', '');
			$this->form_validation->set_rules('members[]', 'Members', '');
			$this->form_validation->set_rules('roles[]', 'Roles', '');

			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit']);
				$this->bitauth->update_group($group_id, $this->input->post());
				redirect('example/groups');
			}

		}

		$users = array();
		foreach($this->bitauth->get_users() as $_user)
		{
			$users[$_user->user_id] = $_user->fullname;
		}

		$group = $this->bitauth->get_group_by_id($group_id);

		$role_list = array();
		$roles = $this->bitauth->get_roles();
		foreach($roles as $_slug => $_desc)
		{
			if($this->bitauth->has_role($_slug, $group->roles))
			{
				$role_list[] = $_slug;
			}
		}

		$this->load->view('example/edit_group', array('bitauth' => $this->bitauth, 'roles' => $roles, 'group' => $group, 'group_roles' => $role_list, 'users' => $users));
	}


	/**
	 * Example::groups()
	 *
	 */
	public function permissions()
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		$this->load->view('example/permissions', array('bitauth' => $this->bitauth, 'permissions' => $this->bitauth->get_permissions()));
	}

	/**
	 * Example::add_group()
	 *
	 */
	public function add_permissions()
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		if ( ! $this->bitauth->has_role('admin'))
		{
			$this->load->view('example/no_access');
			return;
		}

		if($this->input->post())
		{
			$this->form_validation->set_rules('permission_name', 'Permission Name', 'trim|required|bitauth_unique_permission_name');
			$this->form_validation->set_rules('permission_key', 'Permission Key', 'trim|required|bitauth_unique_permission_key');
			$this->form_validation->set_rules('groups[]', 'Groups', '');


			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit']);
				$this->bitauth->add_permission($this->input->post());
				redirect('example/permissions');
			}

		}

		$groups = array();
		foreach($this->bitauth->get_groups() as $_group)
		{
			$groups[$_group->group_id] = $_group->name;
		}

		$this->load->view('example/add_permissions', array('bitauth' => $this->bitauth,  'groups' => $groups));
	}

	/**
	 * Example:edit_group()
	 *
	 */
	public function edit_permission($permission_id)
	{
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}

		if ( ! $this->bitauth->has_role('admin'))
		{
			$this->load->view('example/no_access');
			return;
		}

		if($this->input->post())
		{
			$this->form_validation->set_rules('permission_name', 'Permission Name', 'trim|required|bitauth_unique_permission_name['.$permission_id.']');
			$this->form_validation->set_rules('permission_key', 'Permission Key', 'trim|required|bitauth_unique_permission_key['.$permission_id.']');
			$this->form_validation->set_rules('groups[]', 'Groups', '');

			if($this->form_validation->run() == TRUE)
			{
				unset($_POST['submit']);
				$this->bitauth->update_permission($permission_id, $this->input->post());
				redirect('example/permissions');
			}

		}

		$groups = array();
		foreach($this->bitauth->get_groups() as $_group)
		{
			$groups[$_group->group_id] = $_group->name;
		}

		$permission = $this->bitauth->get_permission_by_id($permission_id);


		$this->load->view('example/edit_permissions', array('bitauth' => $this->bitauth, 'groups' => $groups,  'permission' => $permission));
	}


	/**
	 * Example::activate()
	 *
	 */
	 public function activate($activation_code)
	 {
	 	if($this->bitauth->activate($activation_code))
	 	{
	 		$this->load->view('example/activation_successful');
	 		return;
	 	}

	 	$this->load->view('example/activation_failed');
	 }

     public function checkAuth($perm_key=0) {
		if( ! $this->bitauth->logged_in())
		{
			$this->session->set_userdata('redir', current_url());
			redirect('example/login');
		}
        if($this->bitauth->has_permission($perm_key)) {
            echo "Has $perm_key privilege";
        }else {
            echo "$perm_key Restricted ";
        }

     }


	/**
	 * Example::logout()
	 *
	 */
	public function logout()
	{
		$this->bitauth->logout();
		redirect('example');
	}

}